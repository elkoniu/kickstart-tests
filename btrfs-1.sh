#
# Copyright (C) 2014  Red Hat, Inc.
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions of
# the GNU General Public License v.2, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY expressed or implied, including the implied warranties of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.  You should have received a copy of the
# GNU General Public License along with this program; if not, write to the
# Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.  Any Red Hat trademarks that are incorporated in the
# source code or documentation are not subject to the GNU General Public
# License and may only be used or replicated with the express permission of
# Red Hat, Inc.
#
# Red Hat Author(s): Chris Lumens <clumens@redhat.com>

# Ignore unused variable parsed out by tooling scripts as test tags metadata
# shellcheck disable=SC2034
TESTTYPE="btrfs storage skip-on-rhel"

. ${KSTESTDIR}/functions.sh

validate() {
    disksdir=$1
    args=$(for d in ${disksdir}/disk-*img; do echo -a ${d}; done)

    # There should be a /root/root/RESULT file with results in it.  Check
    # its contents and decide whether the test finally succeeded or
    # not.
    result=$(virt-cat ${args} -m /dev/disk/by-label/fedora-btrfs /root/root/RESULT)
    if [[ $? != 0 ]]; then
        status=1
        echo '*** /root/RESULT does not exist in VM image.'
    elif [[ "${result}" != "SUCCESS" ]]; then
        status=1
        echo "${result}"
    fi

    return ${status}
}

