format:
	stylua .

cleanup:
	rm -rdf ~/.local/share/nvim/
	rm -rdf ~/.local/state/nvim/
	rm -rdf ~/.cache/nvim
	echo 'cleaned up done'

commit-push:
	git add .
	git commit -m "automated commit $(shell date +'%Y-%m-%d %H:%M:%S')"
	git push origin master

amend-push:
	git add .
	git commit --amend -m "automated commit $(shell date +'%Y-%m-%d %H:%M:%S')"
	git push origin master --force
