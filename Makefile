# Builds diffs and renders the documentation file.
#
# Targets:
#   all            - rebuild diffs and render knowledge-base.md from knowledge-base.md.tmpl (default)
#   clean          - remove all generated files (diffs and knowledge-base.md)
#   install-hooks  - install the pre-commit hook that prevents committing a stale knowledge-base.md
#
# For each article directory under articles/, generates a unified diff between old.txt and
# new.txt and writes it to diffs/<article>.diff. Only rebuilds if sources changed (use -B to
# force all). Labels omit timestamps; exit code 1 from diff (files differ) is suppressed.
#
# knowledge-base.md is rendered by expanding {{...}} markers (e.g. {{articles/N/old.txt}},
# {{articles/N/new.txt}}, {{diffs/N.diff}}) in knowledge-base.md.tmpl using awk.

ARTICLES := $(notdir $(wildcard articles/*))
DIFFS    := $(addprefix diffs/,$(addsuffix .diff,$(ARTICLES)))

.PHONY: all clean install-hooks

all: $(DIFFS) knowledge-base.md

diffs/%.diff: articles/%/old.txt articles/%/new.txt
	diff -u --label articles/$*/old.txt --label articles/$*/new.txt $^ > $@ || true

knowledge-base.md: knowledge-base.md.tmpl $(DIFFS)
	awk '/^\{\{.*\}\}$$/{f=substr($$0,3,length($$0)-4);while((getline l<f)>0)print l;close(f);next}1' $< > $@

clean:
	rm -f $(DIFFS) knowledge-base.md

install-hooks:
	ln -sf ../../hooks/pre-commit .git/hooks/pre-commit
	chmod +x hooks/pre-commit
