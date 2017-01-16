WORK_DIR=/usr/src/app

.PHONY: build boot bash ssh run
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
