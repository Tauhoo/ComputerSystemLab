
echo '' > result.cache

echo 512 8 1 > cache.config
gcc ./CacheSim.c && ./a.out traceB.dat 
result=$(grep '^Overall miss ratio: ' matrix.cache)
echo "512 8 1 => $result" >> result.cache

echo 512 16 1 > cache.config
gcc ./CacheSim.c && ./a.out traceB.dat 
result=$(grep '^Overall miss ratio: ' matrix.cache)
echo "512 16 1 => $result" >> result.cache

echo 512 32 1 > cache.config
gcc ./CacheSim.c && ./a.out traceB.dat 
result=$(grep '^Overall miss ratio: ' matrix.cache)
echo "512 32 1 => $result" >> result.cache

echo 512 64 1 > cache.config
gcc ./CacheSim.c && ./a.out traceB.dat 
result=$(grep '^Overall miss ratio: ' matrix.cache)
echo "512 64 1 => $result" >> result.cache

echo 4096 8 1 > cache.config
gcc ./CacheSim.c && ./a.out traceB.dat 
result=$(grep '^Overall miss ratio: ' matrix.cache)
echo "4096 8 1 => $result" >> result.cache

echo 4096 16 1 > cache.config
gcc ./CacheSim.c && ./a.out traceB.dat 
result=$(grep '^Overall miss ratio: ' matrix.cache)
echo "4096 16 1 => $result" >> result.cache

echo 4096 32 1 > cache.config
gcc ./CacheSim.c && ./a.out traceB.dat 
result=$(grep '^Overall miss ratio: ' matrix.cache)
echo "4096 32 1 => $result" >> result.cache

echo 4096 64 1 > cache.config
gcc ./CacheSim.c && ./a.out traceB.dat 
result=$(grep '^Overall miss ratio: ' matrix.cache)
echo "4096 64 1 => $result" >> result.cache

echo 1048576 8 1 > cache.config
gcc ./CacheSim.c && ./a.out traceB.dat 
result=$(grep '^Overall miss ratio: ' matrix.cache)
echo "1048576 8 1 => $result" >> result.cache

echo 1048576 16 1 > cache.config
gcc ./CacheSim.c && ./a.out traceB.dat 
result=$(grep '^Overall miss ratio: ' matrix.cache)
echo "1048576 16 1 => $result" >> result.cache

echo 1048576 32 1 > cache.config
gcc ./CacheSim.c && ./a.out traceB.dat 
result=$(grep '^Overall miss ratio: ' matrix.cache)
echo "1048576 32 1 => $result" >> result.cache

echo 1048576 64 1 > cache.config
gcc ./CacheSim.c && ./a.out traceB.dat 
result=$(grep '^Overall miss ratio: ' matrix.cache)
echo "1048576 64 1 => $result" >> result.cache

rm a.out matrix.cache