pagebreak = Style/pandoc_page_break.txt

CHAPTER_01 += intro.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += installation.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += tools_command_getting_started_linux.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += users_and_groups.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += modbits.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += nano.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += bash.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += links_and_aliases.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += processes.md
CHAPTER_01 += ${pagebreak}
# CHAPTER_01 += text.md
# CHAPTER_01 += ${pagebreak}
CHAPTER_01 += integration_excercise.md
CHAPTER_01 += ${pagebreak}
CHAPTER_01 += integration_excercise_sol.md
CHAPTER_01 += ${pagebreak}
CHAPTER_02 += integration_test_part.md
CHAPTER_02 += ${pagebreak}
CHAPTER_02 += intro_part2.md
CHAPTER_02 += ${pagebreak}
CHAPTER_02 += apt.md
CHAPTER_02 += ${pagebreak}
CHAPTER_02 += systemd.md
CHAPTER_02 += ${pagebreak}
CHAPTER_02 += fedora.md
CHAPTER_02 += ${pagebreak}
CHAPTER_02 += ip.md
# CHAPTER_02 += nm_to_networkd.md
CHAPTER_02 += ${pagebreak}
CHAPTER_02 += internnetwork.md
CHAPTER_02 += ${pagebreak}
CHAPTER_02 += ssh.md



CHAPTERS += $(CHAPTER_01) $(CHAPTER_02)

all:
	pandoc $(CHAPTERS) -o dist/basis_linux.epub --css ./Style/base.css\

	pandoc $(CHAPTERS) -o dist/basis_linux.html --self-contained -s --toc --toc-depth=5  -c ./Style/github-pandoc.css

	wkhtmltopdf dist/basis_linux.html dist/basis_linux.pdf

	zip dist/basis_linux.zip dist/basis_linux.epub dist/basis_linux.html dist/basis_linux.pdf
