#!/bin/sh
set -eux
version=$(dpkg-parsechangelog -SVersion | sed -E 's/(\+dfsg)?-.*//')
url=$(curl https://pypi.org/simple/pydata-sphinx-theme/ | grep -Eo "https://files\.pythonhosted\.org/packages/[0-9a-f/]+/pydata_sphinx_theme-${version}-py3-none-any\.whl")
destdir=$(dirname "$0")
curl -v "${url}" | bsdtar -xf - -C "${destdir}" --strip-components 4 \
    pydata_sphinx_theme/theme/pydata_sphinx_theme/static/styles/pydata-sphinx-theme.css \
    pydata_sphinx_theme/theme/pydata_sphinx_theme/static/styles/pydata-sphinx-theme.css.map
echo "${version}" > "${destdir}/version"
