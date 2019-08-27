REPOSITORIES_PATH = repositories
DISTRIBUTIONS = debian
ARCHITECTURES = amd64
CODE_NAMES = buster
RSYNC_PATH = packages@packages.groonga.org:public
PACKAGE_LABEL = "Groonga"
GPG_UID = `cat $(GROONGA_REPOSITORY_PATH)/gpg_uid`

all:

release: download build sign-packages update-repository sign-repository upload

ensure-groonga-repository-path:
	@if test -z "$(GROONGA_REPOSITORY_PATH)"; then						\
	  echo "Set GROONGA_REPOSITORY_PATH environment variable (e.g. /work/groonga/groonga)";	\
	  false;										\
        fi

download:
	for distribution in $(DISTRIBUTIONS); do	\
	  rsync -avz --progress --delete		\
	    $(RSYNC_PATH)/$${distribution}		\
	    ${REPOSITORIES_PATH}/;			\
	done

build:
	cd ..
	rake apt

sign-packages: ensure-groonga-repository-path
	$(GROONGA_REPOSITORY_PATH)/packages/apt/sign-packages.sh $(GPG_UID) '$(REPOSITORIES_PATH)/' '$(CODE_NAMES)'

update-repository: ensure-groonga-repository-path
	$(GROONGA_REPOSITORY_PATH)/packages/apt/update-repository.sh '$(PACKAGE_LABEL)' '$(REPOSITORIES_PATH)/' \
	  '$(ARCHITECTURES)' '$(CODE_NAMES)'

sign-repository: ensure-groonga-repository-path
	$(GROONGA_REPOSITORY_PATH)/packages/apt/sign-repository.sh '$(GPG_UID)' '$(REPOSITORIES_PATH)/' '$(CODE_NAMES)'

upload: ensure-rsync-path
	for distribution in $(DISTRIBUTIONS); do		\
	  (cd $(REPOSITORIES_PATH)/$${distribution};		\
	   rsync -avz --progress --delete			\
	     dists pool $(RSYNC_PATH)/$${distribution});	\
	done
