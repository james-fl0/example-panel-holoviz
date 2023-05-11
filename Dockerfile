FROM continuumio/miniconda3
WORKDIR /app
RUN ["conda", "create", "-y", "-n", "project"]
RUN ["conda", "init"]
WORKDIR /app/holoviz_tutorial
# RUN --mount=type=cache,target=/root/.cache/pip ["conda", "run", "--no-capture-output", "-n", "project", "pip", "install", "jupyterlab", "panel", "pandas"]
RUN ["conda", "run", "--no-capture-output", "-n", "project", "pip", "install", "jupyterlab", "panel", "pandas"]
EXPOSE 8888
COPY ./main.py ./

ENV BOKEH_ALLOW_WS_ORIGIN="tiempo-duos-5szv-dev.fl0.io"

ENTRYPOINT [ "bash", "-c", "conda run --no-capture-output -n project panel serve main.py --address 0.0.0.0 --port $PORT --liveness --liveness-endpoint healthcheck"]
