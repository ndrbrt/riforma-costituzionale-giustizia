# Builds diffs and renders the documentation file.
#
# Targets:
#   all            - rebuild diffs and render docs.md from docs.md.tmpl (default)
#   clean          - remove all generated files (diffs and docs.md)
#   install-hooks  - install the pre-commit hook that prevents committing a stale docs.md
#
# For each article directory under articles/, generates a unified diff between old.txt and
# new.txt and writes it to diffs/<article>.diff. Only rebuilds if sources changed (use -B to
# force all). Labels omit timestamps; exit code 1 from diff (files differ) is suppressed.
#
# docs.md is rendered by expanding {{...}} markers (e.g. {{articles/N/old.txt}},
# {{articles/N/new.txt}}, {{diffs/N.diff}}) in docs.md.tmpl using awk.

ARTICLES := $(notdir $(wildcard articles/*))
DIFFS    := $(addprefix diffs/,$(addsuffix .diff,$(ARTICLES)))

.PHONY: all clean install-hooks

all: $(DIFFS) docs.md

diffs/%.diff: articles/%/old.txt articles/%/new.txt
	diff -u --label articles/$*/old.txt --label articles/$*/new.txt $^ > $@ || true

docs.md: docs.md.tmpl $(DIFFS)
	awk '/^\{\{.*\}\}$$/{f=substr($$0,3,length($$0)-4);while((getline l<f)>0)print l;close(f);next}1' $< > $@

clean:
	rm -f $(DIFFS) docs.md

install-hooks:
	ln -sf ../../hooks/pre-commit .git/hooks/pre-commit
	chmod +x hooks/pre-commit
