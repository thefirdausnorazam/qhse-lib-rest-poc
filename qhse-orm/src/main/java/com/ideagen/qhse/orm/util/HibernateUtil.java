package com.ideagen.qhse.orm.util;

import java.util.List;
import java.util.Map;

import org.hibernate.SessionFactory;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

import com.github.fluent.hibernate.cfg.scanner.EntityScanner;
import com.ideagen.qhse.orm.entity.Domain;
import com.ideagen.qhse.orm.entity.ProfileChecklistTask;
import com.ideagen.qhse.orm.entity.QuestionOption;
import com.ideagen.qhse.orm.entity.RiskBusinessArea;
import com.ideagen.qhse.orm.entity.Role;
import com.ideagen.qhse.orm.entity.Site;
import com.ideagen.qhse.orm.entity.User;

public class HibernateUtil {

	private static StandardServiceRegistry registry;
	private static SessionFactory sessionFactory;
	
	public static String ENTITY_PACKAGE = "com.ideagen.qhse.orm.entity";

	public static SessionFactory getSessionFactory(Map<String, String> ormProperties) {
		if (sessionFactory == null) {
			try {

				StandardServiceRegistryBuilder registryBuilder = new StandardServiceRegistryBuilder();

				// Apply settings
				registryBuilder.applySettings(ormProperties);

				// Create registry
				registry = registryBuilder.build();

				// Create MetadataSources
				MetadataSources sources = new MetadataSources(registry);
				
				// Register all the entities here.
				/*sources.addAnnotatedClass(User.class);
		        sources.addAnnotatedClass(Role.class);
		        sources.addAnnotatedClass(Domain.class);
		        sources.addAnnotatedClass(QuestionOption.class);
		        sources.addAnnotatedClass(ProfileChecklistTask.class);
		        sources.addAnnotatedClass(Site.class);
		        sources.addAnnotatedClass(RiskBusinessArea.class);*/
		        
				//scan all the entities under the package com.ideagen.qhse.orm.entity
		        List<Class<?>> classes = EntityScanner.scanPackages(ENTITY_PACKAGE).result();
		        
		        for (Class<?> annotatedClass : classes) {
		        	//System.out.println(annotatedClass.getName());
		        	sources.addAnnotatedClass(annotatedClass);
		        }
		        
				// Create Metadata
				Metadata metadata = sources.getMetadataBuilder().build();

				// Create SessionFactory
				sessionFactory = metadata.getSessionFactoryBuilder().build();
			} catch (Exception e) {
				e.printStackTrace();
				if (registry != null) {
					StandardServiceRegistryBuilder.destroy(registry);
				}
			}
		}
		return sessionFactory;
	}

	public static void shutdown() {
		if (registry != null) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
	}
	
	
}