sudo wget https://github.com/jgm/pandoc/releases/download/3.1.7/pandoc-3.1.7-1-amd64.deb
sudo dpkg -i pandoc-3.1.7-1-amd64.deb
cd manual_tau_argus_to_quarto/
pandoc --extract-media=Media TauManualV4.1_Rev.odt -o TauManualV4.1_Rev.md