all: update_index upload_charts

update_index:
	cr index --owner gndra --git-repo rem-charts \
		--charts-repo https://github.com/gndra/rem-charts \
		--token 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

upload_charts:
	cr upload --owner gndra --git-repo rem-charts \
		--token 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