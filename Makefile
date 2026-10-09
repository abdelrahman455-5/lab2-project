setup:
	mkdir -p quarantine

run-antivirus: setup
	./antivirusd.sh watch_dir quarantine 5

run-restore:
	./restore.sh watch_dir quarantine
