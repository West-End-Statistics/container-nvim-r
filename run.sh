podman run -ti --rm -p 6543:6543 \
	--volume $PWD:/project \
	--volume $PWD/config/nvim:/root/.config/nvim/ \
	--security-opt label=disable container-nvim-r

