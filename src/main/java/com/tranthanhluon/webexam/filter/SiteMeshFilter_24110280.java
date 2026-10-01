package com.tranthanhluon.webexam.filter;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class SiteMeshFilter_24110280 extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.addDecoratorPath("/admin/*", "admin-decorator.jsp");
        builder.addDecoratorPath("/*", "user-decorator.jsp");
        builder.addExcludedPath("/assets/*");
    }
}
