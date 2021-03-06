#
# Author:: Chris Jones <cjones303@bloomberg.net>
# Cookbook Name:: chef-bcs
#
# Copyright 2017, Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'chef-bcs::ceph-conf'

template '/etc/ceph/scripts/restart_down_osds.sh' do
    source 'restart_down_osds.sh.erb'
    mode 00755
end

%W( if_leader health_filter ).each do |script|
    link "/usr/local/bin/ceph_#{script}.sh" do
        to "/etc/ceph/scripts/ceph_#{script}.sh"
    end
end
