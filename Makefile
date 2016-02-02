.PHONY: deps2 compile2 rel2 run2
.PHONY: compile3 rel3 run3
.PHONY: clean
.PHONY: build_plt dialyzer

REBAR2=./rebar
REBAR3=./rebar3

DIALYZER_APPS = asn1 compiler crypto erts inets kernel public_key sasl ssl stdlib syntax_tools tools

## rebar2
deps2:
		$(REBAR2) get-deps

compile2: deps2
		$(REBAR2) compile

rel2: compile2
		$(REBAR2) generate -f

run2:
		erl -pa deps/*/ebin ebin -config config/sys.config -args_file config/vm.args -boot start_sasl -s sync -s myapp

## rebar3
compile3:
		$(REBAR3) compile

rel3: compile3
		$(REBAR3) release

run3:
		erl -pa _build/default/lib/*/ebin -config config/sys.config -args_file config/vm.args -boot start_sasl -s sync -s myapp


clean:
		$(REBAR2) clean
		$(REBAR3) clean
		rm -rf ./log
		rm -rf ./test/*.beam
		rm -rf ./test/TEST*.xml
		rm -rf ./erl_crash.dump
		rm -rf _rel
		rm -rf _build
		rm -rf release/myapp.boot
		rm -rf release/myapp.script
		rm -rf release/myapp.tar.gz
		rm -rf reltool/myapp/*
		rm -rf rel/myapp

build_plt: clean compile
ifneq ("$(wildcard erlang.plt)","")
		@echo "Erlang plt file already exists"
else
		dialyzer --build_plt --output_plt erlang.plt --apps $(DIALYZER_APPS)
endif
ifneq ("$(wildcard myapp.plt)","")
		@echo "myapp plt file already exists"
else
		dialyzer --build_plt --output_plt myapp.plt _build/default/lib/*/ebin
endif

add_to_plt: build_plt
		dialyzer --add_to_plt --plt erlang.plt --output_plt erlang.plt.new --apps $(DIALYZER_APPS)
		dialyzer --add_to_plt --plt myapp.plt --output_plt sber_proxy.plt.new _build/default/lib/*/ebin
		mv erlang.plt.new erlang.plt
		mv myapp.plt.new sber_proxy.plt

dialyzer:
		dialyzer --src src --plts erlang.plt myapp.plt -Wunmatched_returns -Werror_handling -Wrace_conditions -Wunderspecs | fgrep -v -f ./dialyzer.ignore-warnings

