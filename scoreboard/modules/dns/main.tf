/*
 * Creating zone as detail here:
 * https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/migrate-dns-domain-inactive.html#migrate-dns-create-hosted-zone-domain-inactive
 */
resource "aws_route53_zone" "secops-ctf-zone" {
  name = "ellingson.io"
  vpc {
    vpc_id = var.dns_vpc
  }
}

resource "aws_route53_record" "secops-ctf-record" {
  allow_overwrite = true
  name            = "ellingson.io"
  ttl             = 30
  type            = "NS"
  zone_id         = aws_route53_zone.secops-ctf-zone.zone_id

  records = [
    aws_route53_zone.secops-ctf-zone.name_servers[0],
    aws_route53_zone.secops-ctf-zone.name_servers[1],
    aws_route53_zone.secops-ctf-zone.name_servers[2],
    aws_route53_zone.secops-ctf-zone.name_servers[3],
  ]
}

resource "aws_route53_record" "gibson" {
  zone_id = aws_route53_zone.secops-ctf-zone.zone_id
  name    = "gibson.ellingson.io"
  type    = "A"
  ttl     = "300"
  records = var.dns_arecord[0]
}

resource "aws_route53_record" "scoreboard" {
  zone_id = aws_route53_zone.secops-ctf-zone.zone_id
  name    = "scoreboard.ellingson.io"
  type    = "A"
  ttl     = "300"
  records = var.dns_arecord[1]
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
