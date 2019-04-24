USE test;

DROP TABLE IF EXISTS ipv6_range;
CREATE TABLE ipv6_range(ip FixedString(16), cidr UInt8) ENGINE = Memory;

INSERT INTO ipv6_range (ip, cidr) VALUES (IPv6StringToNum('2001:0db8:0000:85a3:0000:0000:ac1f:8001'), 0), (IPv6StringToNum('2001:0db8:0000:85a3:ffff:ffff:ffff:ffff'), 32), (IPv6StringToNum('ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'), 16), (IPv6StringToNum('2001:df8:0:85a3::ac1f:8001'), 32), (IPv6StringToNum('2001:0db8:85a3:85a3:0000:0000:ac1f:8001'), 16), (IPv6StringToNum('0000:0000:0000:0000:0000:0000:0000:0000'), 8), (IPv6StringToNum('ffff:0000:0000:0000:0000:0000:0000:0000'), 4);

WITH IPv6CIDRtoIPv6Range(IPv6StringToNum('2001:0db8:0000:85a3:0000:0000:ac1f:8001'), 32) as ip_range SELECT COUNT(*) FROM ipv6_range WHERE ip BETWEEN tupleElement(ip_range, 1) AND tupleElement(ip_range, 2);

WITH IPv6CIDRtoIPv6Range(IPv6StringToNum('2001:0db8:0000:85a3:0000:0000:ac1f:8001'), 25) as ip_range SELECT COUNT(*) FROM ipv6_range WHERE ip BETWEEN tupleElement(ip_range, 1) AND tupleElement(ip_range, 2);

WITH IPv6CIDRtoIPv6Range(IPv6StringToNum('2001:0db8:0000:85a3:0000:0000:ac1f:8001'), 26) as ip_range SELECT COUNT(*) FROM ipv6_range WHERE ip BETWEEN tupleElement(ip_range, 1) AND tupleElement(ip_range, 2);

WITH IPv6CIDRtoIPv6Range(IPv6StringToNum('2001:0db8:0000:85a3:0000:0000:ac1f:8001'), 64) as ip_range SELECT COUNT(*) FROM ipv6_range WHERE ip BETWEEN tupleElement(ip_range, 1) AND tupleElement(ip_range, 2);

WITH IPv6CIDRtoIPv6Range(IPv6StringToNum('2001:0db8:0000:85a3:0000:0000:ac1f:8001'), 0) as ip_range SELECT COUNT(*) FROM ipv6_range WHERE ip BETWEEN tupleElement(ip_range, 1) AND tupleElement(ip_range, 2);

WITH IPv6CIDRtoIPv6Range(ip, cidr) as ip_range SELECT IPv6NumToString(ip), cidr, IPv6NumToString(tupleElement(ip_range, 1)), IPv6NumToString(tupleElement(ip_range, 2)) FROM ipv6_range;

DROP TABLE ipv6_range;

WITH IPv6CIDRtoIPv6Range(IPv6StringToNum('2001:0db8:0000:85a3:0000:0000:ac1f:8001'), 0) as ip_range SELECT IPv6NumToString(tupleElement(ip_range, 1)) as lower_range, IPv6NumToString(tupleElement(ip_range, 2)) as higher_range;

WITH IPv6CIDRtoIPv6Range(IPv6StringToNum('2001:0db8:0000:85a3:0000:0000:ac1f:8001'), 128) as ip_range SELECT IPv6NumToString(tupleElement(ip_range, 1)) as lower_range, IPv6NumToString(tupleElement(ip_range, 2)) as higher_range;

WITH IPv6CIDRtoIPv6Range(IPv6StringToNum('ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'), 64) as ip_range SELECT IPv6NumToString(tupleElement(ip_range, 1)) as lower_range, IPv6NumToString(tupleElement(ip_range, 2)) as higher_range;

WITH IPv6CIDRtoIPv6Range(IPv6StringToNum('0000:0000:0000:0000:0000:0000:0000:0000'), 8) as ip_range SELECT IPv6NumToString(tupleElement(ip_range, 1)) as lower_range, IPv6NumToString(tupleElement(ip_range, 2)) as higher_range;

WITH IPv6CIDRtoIPv6Range(IPv6StringToNum('ffff:0000:0000:0000:0000:0000:0000:0000'), 4) as ip_range SELECT IPv6NumToString(tupleElement(ip_range, 1)) as lower_range, IPv6NumToString(tupleElement(ip_range, 2)) as higher_range;

