variable "dns_vpc" {
  description = "VPC ID to use for DNS setup"
  type        = string
}

variable "dns_hostname" {
  description = "List of hostnames to associate with our ec2 instances"
  type        = list
}

variable "dns_arecord" {
  description = ""
  type        = list
}

/**
 *  Copyright 2019 Palo Alto Networks.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
