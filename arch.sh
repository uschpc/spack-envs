# source arch.sh

# Detect microarchitecture and activate corresponding environment

source /project/ttrojan_123/spack.sh

arch="$(spack arch -t)"

if [[ "$arch" = "skylake_avx512" ]]; then
  spack env activate myenv-skylake-avx512
elif [[ "$arch" = "zen3" ]]; then
  spack env activate myenv-zen3
else
  printf "%s%s\n" "Environment not available for microarchitecture: " "$arch"
  exit 1
fi
