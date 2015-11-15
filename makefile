build:
	mkdocs build --clean

serve: build
	mkdocs serve

clean:
	/bin/rm -rf site
