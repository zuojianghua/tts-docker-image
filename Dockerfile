FROM nvcr.io/nvidia/pytorch:22.12-py3
WORKDIR /workspace
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
USER root
EXPOSE 8800
RUN apt-get update && apt-get upgrade -y && apt-get install git -y
# COPY ./requirements.txt /workspace
# RUN export FORCE_CUDA="1" && export TORCH_CUDA_ARCH_LIST="6.1;7.5;8.6;8.9" && pip install -r /workspace/requirements.txt
RUN git clone https://github.com/neonbjb/tortoise-tts.git
RUN cd tortoise-tts && python -m pip install -r ./requirements.txt && python setup.py install
# RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && pip install -r /workspace/requirements.txt
# RUN pip install git+https://github.com/openai/CLIP.git
# RUN git clone https://github.com/pharmapsychotic/clip-interrogator.git
ENTRYPOINT ["jupyter-lab","--no-browser","--allow-root","--port=8800","--ip=0.0.0.0","--ServerApp.token=123456"]
