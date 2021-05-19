all: package_charts upload_charts update_index

package_charts:
		for d in charts/*/; do cr package $$d --config config.yaml; done

update_index:
	cr index --config config.yaml

upload_charts:
	cr upload --config config.yaml