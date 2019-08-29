package com.ideagen.qhse.web.sitemesh;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class LayoutFilter extends ConfigurableSiteMeshFilter {
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder
                .addDecoratorPath("/login", "/decorators/loginDecorator")
                .addDecoratorPath("/login-error", "/decorators/loginDecorator")
                .addDecoratorPath("/law/taskQueryResult.htmf", "/decorators/noDecorator")
                .addDecoratorPath("/law/taskQueryForm.htm", "/decorators/frameDecorator")
                .addDecoratorPath("/error", "/decorators/noDecorator")
                .addDecoratorPath("/home", "/decorators/frameDecorator");

    }
}