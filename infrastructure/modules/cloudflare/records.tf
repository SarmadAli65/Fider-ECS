data "cloudflare_zone" "domain_zoneid"{
    filter = {
      name = var.domain_name
    }
    
}

resource "cloudflare_dns_record" "alb_dns_record" {
    zone_id = data.cloudflare_zone.domain_zoneid.id
    ttl = 1
    type = "CNAME"
    name = "www.${var.domain_name}"
    content = var.alb_dns
    proxied = false
}

