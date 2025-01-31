"""Starlark representation of locked requirements.

@generated by rules_python pip_parse repository rule
from @rules_fuzzing//fuzzing:requirements.txt
"""

load("@rules_python//python/pip_install:pip_repository.bzl", "whl_library")

all_requirements = ["@fuzzing_pip3_absl_py//:pkg", "@fuzzing_pip3_six//:pkg"]

all_whl_requirements = ["@fuzzing_pip3_absl_py//:whl", "@fuzzing_pip3_six//:whl"]

all_data_requirements = ["@fuzzing_pip3_absl_py//:data", "@fuzzing_pip3_six//:data"]

_packages = [("fuzzing_pip3_absl_py", "absl-py==0.11.0 --hash=sha256:b3d9eb5119ff6e0a0125f6dabf2f9fae02f8acae7be70576002fac27235611c5"), ("fuzzing_pip3_six", "six==1.15.0 --hash=sha256:8b74bedcbbbaca38ff6d7491d76f2b06b3592611af620f8426e82dddb04a5ced")]
_config = {"download_only": False, "enable_implicit_namespace_pkgs": False, "environment": {}, "extra_pip_args": ["--require-hashes"], "isolated": True, "pip_data_exclude": [], "python_interpreter": "python3", "python_interpreter_target": "@python3_11_x86_64-unknown-linux-gnu//:bin/python3", "quiet": True, "repo": "fuzzing_pip3", "repo_prefix": "fuzzing_pip3_", "timeout": 600}
_annotations = {}

def _clean_name(name):
    return name.replace("-", "_").replace(".", "_").lower()

def requirement(name):
    return "@fuzzing_pip3_" + _clean_name(name) + "//:pkg"

def whl_requirement(name):
    return "@fuzzing_pip3_" + _clean_name(name) + "//:whl"

def data_requirement(name):
    return "@fuzzing_pip3_" + _clean_name(name) + "//:data"

def dist_info_requirement(name):
    return "@fuzzing_pip3_" + _clean_name(name) + "//:dist_info"

def entry_point(pkg, script = None):
    if not script:
        script = pkg
    return "@fuzzing_pip3_" + _clean_name(pkg) + "//:rules_python_wheel_entry_point_" + script

def _get_annotation(requirement):
    # This expects to parse `setuptools==58.2.0     --hash=sha256:2551203ae6955b9876741a26ab3e767bb3242dafe86a32a749ea0d78b6792f11`
    # down to `setuptools`.
    name = requirement.split(" ")[0].split("=")[0].split("[")[0]
    return _annotations.get(name)

def install_deps(**whl_library_kwargs):
    whl_config = dict(_config)
    whl_config.update(whl_library_kwargs)
    for name, requirement in _packages:
        whl_library(
            name = name,
            requirement = requirement,
            annotation = _get_annotation(requirement),
            **whl_config
        )
