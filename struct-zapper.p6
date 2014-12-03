use v6;

my $struct = '
struct git_repository {
	git_odb *_odb;
	git_refdb *_refdb;
	git_config *_config;
	git_index *_index;
	git_submodule_cache *_submodules;

	git_cache objects;
	git_attr_cache *attrcache;
	git_diff_driver_registry *diff_drivers;

	char *path_repository;
	char *workdir;
	char *namespace;

	unsigned is_bare:1;
	unsigned int lru_counter;

	git_cvar_value cvar_cache[GIT_CVAR_CACHE_MAX];
};';

grammar CStruct {
    token TOP { \s+?<typedef>\s*'{'\s+ [<member>+ % \s+]+ \s+? '}'';'? };

    rule typedef {struct [\w]+}

    token type { :r [\w]+ }

    token member { [<type>\s+] ** 1..4 <member-name> ':'? <bitfield>?';' }

    token member-name { ['*'? \s*? \w+('[' ~ ']'\w+)?] }

    token bitfield { [\d+] }
}

say CStruct.parse($struct);
