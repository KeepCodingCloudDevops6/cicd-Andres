FROM andresminguez2/acmeimage

RUN apt-get update

RUN apt-get install curl -y && apt-get install unzip -y
RUN wget https://releases.hashicorp.com/terraform/1.3.3/terraform_1.3.3_linux_amd64.zip && \
    unzip terraform_1.3.3_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    terraform --version

EXPOSE 22
