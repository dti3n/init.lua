format:
	stylua .

cleanup:
	rm -rdf ~/.local/share/nvim/
	rm -rdf ~/.local/state/nvim/
	echo 'cleaned up done'

auto-commit:
	git add .
	git commit -m "automated commit $(shell date +'%Y-%m-%d %H:%M:%S')"
	git push origin master

fixed-commit:
	git add .
	git commit --amend --no-edit
	git push origin master --force
