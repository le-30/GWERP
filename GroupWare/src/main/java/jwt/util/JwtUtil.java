package jwt.util;

import java.util.Date;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class JwtUtil {
	private static final String SECRET_KEY = "dk-wlqdp-rkrh-tlvek.";

	public static String createToken(String emp_no,String empNm, String cmmNm, String deptNm) {
		long now = System.currentTimeMillis();
		return Jwts.builder()
				.setSubject(emp_no)
				.claim("empNm", empNm)
				.claim("cmmNm", cmmNm)
				.claim("deptNm", deptNm)
				.setIssuedAt(new Date(now))
				.setExpiration(new Date(now + 1000L * 60 * 60 * 16))
				.signWith(SignatureAlgorithm.HS256, SECRET_KEY)
				.compact();
	}

	private static Claims parseToken(String token) {
		return Jwts.parser()
				.setSigningKey(SECRET_KEY)
				.parseClaimsJws(token)
				.getBody();
	}

	public static String getEmp_no(String token) {
		return parseToken(token).getSubject();
	}

	public static String getEmpNm(String token) {
		return (String) parseToken(token).get("empNm");
	}
	public static String getCmmNm(String token) {
		return (String) parseToken(token).get("cmmNm");
	}

	public static String getDeptNm(String token) {
		return (String) parseToken(token).get("deptNm");
	}
}
