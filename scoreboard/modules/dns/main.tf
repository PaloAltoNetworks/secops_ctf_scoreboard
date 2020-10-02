resource "aws_route53_zone" "secops-ctf-zone" {
  name = "ellingson.io"
  vpc {
    vpc_id = var.dns_vpc
  }
}

resource "aws_route53_record" "secops-ctf-record" {
  count   = length(var.dns_hostname)
  name    = element(var.dns_hostname, count.index)
  records = element(var.dns_arecord, count.index)
  zone_id = aws_route53_zone.secops-ctf-zone.id
  type    = "A"
  ttl     = "300"
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
