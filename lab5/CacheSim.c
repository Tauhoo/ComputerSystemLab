//Simulates data cache with parameters read from "cache.config"

#include <stdio.h>
#include <string.h>
#include <assert.h>

static int lscount; //total number of load/stores
static int wcount;  //number of writes
static int rcount;  //number of reads
static int wmiss;   //number of write misses;
static int rmiss;   //number of read misses;
static int wbs;     //number of write backs (i.e. write misses that point to dirty lines)

static int size;  // cache size
static int assoc; // associativity
static int block; // block size

static int bbits; // offset bits
static int ibits; // index bits
static int tbits; // tag bits

typedef struct
{
  char dirty;      //dirty bit
  char valid;      //valid bit
  unsigned int ts; //used for LRU policy
  int tag;         //tag
} entry;

static entry **cache;

int logTwo(int num)
{
  int log = -1;
  for (; num != 0; num = num >> 1)
    log++;
  return log;
}

void Initializing()
{

  FILE *f;
  int numsets, i, j; //number of sets in the cache

  lscount = 0;
  wmiss = 0;
  rmiss = 0;

  f = fopen("cache.config", "r");
  assert(NULL != f);
  assert(3 == fscanf(f, "%d %d %d", &size, &block, &assoc));
  fclose(f);

  //make sure all these are powers of two:
  if (!(block && ((block & (block - 1)) == 0)))
  {
    printf("Block size not power of 2\n");
    exit(0);
  }
  if (!(assoc && ((assoc & (assoc - 1)) == 0)))
  {
    printf("Associativity not power of 2\n");
    exit(0);
  }
  if (!(size && ((size & (size - 1)) == 0)))
  {
    printf("Cache size not a power of 2\n");
    exit(0);
  }

  numsets = ((size / block) / assoc);

  bbits = ibits = tbits = 0;

  // **Fill me in**
  // Code to calculate the number of bits for offset, index, and tag goes here

  ibits = logTwo(numsets);
  bbits = logTwo(block);
  tbits = 32 - ibits - bbits;
  //1010

  printf("bbits: %d ibits: %d tbits: %d\n", bbits, ibits, tbits);
  printf("numsets: %d\n", numsets);

  cache = (entry **)malloc(numsets * sizeof(entry *));
  assert(NULL != cache);
  for (i = 0; i < numsets; i++)
  {
    cache[i] = (entry *)malloc(assoc * sizeof(entry));
    for (j = 0; j < assoc; j++)
    {
      cache[i][j].dirty = 0;
      cache[i][j].valid = 0;
      cache[i][j].ts = 0;
      cache[i][j].tag = -1;
    }
  }
}

void CacheAccess(unsigned int v, int type)
{

  // **Fill me in**
  // Declare appropriate variables here

  unsigned int index = v << tbits >> (tbits + bbits);
  int tag = v >> (ibits + bbits);

  entry *set = cache[index];

  char found_valid = 0;
  unsigned int valid = 0;
  char is_write = 0;
  char is_read = 0;

  lscount++;
  if (type == 0)
    rcount++;
  else
    wcount++;

  // **Fill me in**
  //extract tag, index information
  //the low order bits are offsets, and so we ignore them

  for (int i = 0; i < assoc; i++)
  {
    entry entry_block = set[i];
    char valid_bit = entry_block.valid;
    int tag_bit = entry_block.tag;

    if (valid_bit == 0 && found_valid == 0)
    {
      found_valid = 1;
      valid = i;
    }
    if (tag_bit == tag)
    {
      if (type)
      {
        //write hit
        is_write = 1;
        entry_block.dirty = 1;
        return;
      }
      else
      {
        //read hit
        is_read = 1;
        return;
      }
    }
  }

  if (is_write == 0 && type == 1)
  {
    wmiss++;
    if (found_valid)
    {
      //write valid
      set[valid].dirty = 1;
      set[valid].valid = 1;
      set[valid].tag = tag;
    }
    else
    {
      //write miss
      if (set[0].dirty)
        wbs++;
      set[0].dirty = 1;
      set[0].valid = 1;
      set[0].tag = tag;
    }
  }

  if (is_read == 0 && type == 0)
  {
    //read miss
    rmiss++;
    if (found_valid)
    {
      set[valid].dirty = 1;
      set[valid].valid = 1;
      set[valid].tag = tag;
    }
    else
    {
      if (set[0].dirty)
        wbs++;
      set[0].dirty = 0;
      set[0].valid = 1;
      set[0].tag = tag;
    }
  }

  // **Fill me in**
  // your code for cache access goes here
}

void AfterProg(char *progname)
{
  FILE *f;
  char fname[256];

  sprintf(fname, "%s.cache", progname);
  f = fopen(fname, "w");
  assert(NULL != f);

  fprintf(f, "\n");
  fprintf(f, "Cache Parameters:\n");
  fprintf(f, "Cache Size: %d\n", size);
  fprintf(f, "Block Size: %d\n", block);
  fprintf(f, "Associativity: %d\n", assoc);
  fprintf(f, "\n");

  fprintf(f, "Total memory accesses: %d\n", lscount);
  fprintf(f, "Number of hits: %d\n", lscount - rmiss - wmiss);
  fprintf(f, "Number of read misses: %d\n", rmiss);
  fprintf(f, "Number of write misses: %d\n", wmiss);
  fprintf(f, "Number of write backs: %d\n", wbs);
  fprintf(f, "Overall miss ratio: %.5f\n", (100.0 * (rmiss + wmiss)) / lscount);
  fprintf(f, "Read miss ratio: %.5f\n", (100.0 * rmiss) / rcount);
  fprintf(f, "Write miss ratio: %.5f\n", (100.0 * wmiss) / wcount);

  fprintf(f, "\n");
  fclose(f);
}

int main(int argc, char **argv)
{
  FILE *f;
  unsigned int address;
  int type, i;
  char t1[2];

  Initializing();
  f = fopen(argv[1], "r");
  assert(NULL != f);
  while (fscanf(f, "%s %x", t1, &address) == 2)
  {
    if (t1[0] == 'R')
      type = 0;
    else
      type = 1;
    CacheAccess(address, type);
  }
  AfterProg("matrix");
  fclose(f);
  return 0;
}
