package util;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class HypernateUtil {

	// SỬA: Đổi tên Persistence Unit thành tên project của bạn (ví dụ: webbanquanao)
    // Tên này phải trùng khớp với tên trong file persistence.xml
	private static EntityManagerFactory emf=Persistence.createEntityManagerFactory("webbanquanao"); 
	
    public static EntityManager getEntityManager() {
		EntityManager em=emf.createEntityManager();
		return em;
	}
}