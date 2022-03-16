clean:
	@rm -rf .terra*

dev: dev-apply
dev-apply: clean
	@terraform init -backend-config=env/dev-backend.tfvars
	@terraform apply -auto-approve -var-file=env/dev.tfvars

prod: prod-apply
prod-apply: clean
	@terraform init -backend-config=env/prod-backend.tfvars
	@terraform apply -auto-approve -var-file=env/prod.tfvars

dev-destroy: clean
	@terraform init -backend-config=env/dev-backend.tfvars
	@terraform destroy -auto-approve -var-file=env/dev.tfvars

prod-destroy: clean
	@terraform init -backend-config=env/prod-backend.tfvars
	@terraform destroy -auto-approve -var-file=env/prod.tfvars
