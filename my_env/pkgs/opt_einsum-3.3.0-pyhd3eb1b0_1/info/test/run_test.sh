

set -ex



pytest --verbose --pyargs opt_einsum
pip check
exit 0
