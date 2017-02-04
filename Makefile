WORK_DIR=/usr/src/app
LOG_DIR=$(WORK_DIR)/notebook/logs

.PHONY: build boot bash ssh run tensorboard
build:
	docker build -t py36-jupyter .
boot:
	docker run --rm -it \
        --name py36-tips \
        -v $(PWD):$(WORK_DIR) \
        -w $(WORK_DIR) \
        -p 8888:8888 \
        py36-jupyter sh -c "jupyter notebook \
        --notebook-dir=$(WORK_DIR)/notebook \
        --no-browser --port=8888 --ip=*"
bash:
	docker run --rm -it \
        --name py36-tips \
        -v $(PWD):$(WORK_DIR) \
        -w $(WORK_DIR) \
        py36-jupyter /bin/bash
ssh:
	docker exec -it py36-tips /bin/bash
run:
	docker run --rm -it \
        -v $(PWD):$(WORK_DIR) \
        -w $(WORK_DIR) \
        py36-jupyter $(RUN_ARGS)
tensorboard:
	docker run --rm -it \
	-v $(PWD):$(WORK_DIR) \
	-w $(WORK_DIR) \
    -p 6006:6006 \
	py36-jupyter tensorboard --logdir=$(LOG_DIR)
