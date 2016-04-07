define mldb_install_templated_file
$(eval $(call install_templated_file,$(1),$(2),$(3),mldb,mldb/container_files/template_vars.mk,$(J2ENV)))
endef

define mldb_install_templated_directory
$(eval $(call install_templated_directory,$(1),$(2),mldb,mldb/container_files/template_vars.mk,$(J2ENV)))
endef

$(eval $(call mldb_install_templated_file,mldb/container_files/public_html/index.html,$(ALTROOT)/opt/local/public_html/index.html))
$(eval $(call mldb_install_templated_file,mldb/container_files/public_html/licensing.html,$(ALTROOT)/opt/local/public_html/licensing.html))
$(eval $(call mldb_install_templated_file,mldb/container_files/public_html/version.json,$(ALTROOT)/opt/local/public_html/version.json))
$(eval $(call mldb_install_templated_file,mldb/container_files/public_html/5xx.html,$(ALTROOT)/opt/local/public_html/5xx.html))
$(eval $(call mldb_install_templated_file,mldb/container_files/public_html/5xx.json,$(ALTROOT)/opt/local/public_html/5xx.json))
$(eval $(call install_file,mldb/container_files/public_html/favicon.ico,$(ALTROOT)/opt/local/public_html/favicon.ico,444,mldb))

$(eval $(call mldb_install_templated_file,mldb/container_files/init/05-mldb-id-mapping.sh,$(ETC)/my_init.d/05-mldb-id-mapping.sh,555))
$(eval $(call mldb_install_templated_file,mldb/container_files/init/mldb_runner.sh,$(ETC)/service/mldb_runner/run,555))
$(eval $(call mldb_install_templated_file,mldb/container_files/init/nginx_runner.sh,$(ETC)/service/nginx/run,555))
$(eval $(call mldb_install_templated_file,mldb/container_files/mldb_nginx_site.conf,$(ETC)/nginx/sites-enabled/mldb))
$(eval $(call mldb_install_templated_file,mldb/container_files/nginx.conf,$(ETC)/nginx/nginx.conf))
$(eval $(call mldb_install_templated_file,mldb/container_files/init/credentialsd_runner.sh,$(ETC)/service/credentialsd/run,555))
$(eval $(call mldb_install_templated_file,mldb/container_files/init/ipython_notebook_runner.sh,$(ETC)/service/ipython_notebook/run,555))
$(eval $(call mldb_install_templated_file,mldb/container_files/ipython_extra_config.py,$(ALTROOT)/$(IPYTHON_DIR)/config/jupyter_notebook_config.py))
$(eval $(call mldb_install_templated_file,mldb/container_files/ipython_custom.js,$(ALTROOT)/$(IPYTHON_DIR)/config/custom/custom.js))
$(eval $(call mldb_install_templated_file,mldb/container_files/ipython_custom.css,$(ALTROOT)/$(IPYTHON_DIR)/config/custom/custom.css))
$(eval $(call mldb_install_templated_file,mldb/container_files/init/uwsgi_validator_runner.sh,$(ETC)/service/uwsgi_activator_api/run,555))
$(eval $(call mldb_install_templated_file,mldb/container_files/validator_api_config.json,$(ETC)/validator_api_config.json))
$(eval $(call mldb_install_templated_file,mldb/container_files/publickey.pem,$(ETC)/publickey.pem))
$(eval $(call mldb_install_templated_file,mldb/container_files/classifiers.json,$(BIN)/classifiers.json))

$(eval $(call mldb_install_templated_file,mldb/container_files/init/mldb_logger_utils.py,$(ETC)/service/mldb_runner/log/mldb_logger_utils.py,555))

