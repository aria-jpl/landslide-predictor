FROM hysds/pge-base-conda-python368:20200818

LABEL maintainer="hysds"

COPY --chown=ops:ops ./barn/run.sh /home/ops
COPY --chown=ops:ops ./barn/get_param.py /home/ops
COPY --chown=ops:ops ./barn/create_dataset.sh /home/ops
COPY --chown=ops:ops ./barn/do_it.sh /home/ops

USER root

# predictor

RUN mkdir -p ./predictor/{input,output}

COPY ./barn/predictor/pred_ps_package-2.tar.gz ./predictor
COPY ./barn/predictor/install.sh ./predictor
COPY ./barn/predictor/TFManager.py ./predictor
COPY ./barn/predictor/checkpoint ./predictor
COPY ./barn/predictor/run.sh ./predictor

COPY ./barn/predictor/ps.sample.pickle ./predictor

RUN cd ./predictor && \
    sh -xv ./install.sh && \
    rm ./pred_ps_package-2.tar.gz && \
    rm ./install.sh

RUN chown -R ops:ops ./predictor


# plot

RUN mkdir -p ./plot

COPY ./barn/plot ./plot

RUN chown -R ops:ops ./plot


USER ops

# Change to work directory
WORKDIR /home/ops

# Run shell
CMD ["/bin/bash", "--login"]
