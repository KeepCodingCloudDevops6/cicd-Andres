all: init plan apply clean

clean:
	cd .. && cd terraform && rm -fR terraform/ && rm -fR terraform.* && rm -fR .terraform.*

init:
	cd ../terraform && terraform init

plan:
	cd ../terraform && terraform plan

apply:
	cd ../terraform && terraform apply -auto-approve


