package com.tranthanhluon.webexam.service;

import com.tranthanhluon.webexam.dao.CategoryDAOImpl_24110280;
import com.tranthanhluon.webexam.entity.Category_24110280;

import java.util.List;

public class CategoryServiceImpl_24110280 {
    private final CategoryDAOImpl_24110280 categoryDAO = new CategoryDAOImpl_24110280();

    public List<Category_24110280> getAllCategories() {
        return categoryDAO.findAll();
    }

    public Category_24110280 getCategoryById(Integer categoryId) {
        return categoryDAO.findById(categoryId);
    }

    public List<Category_24110280> getCategoriesWithPage(int page, int pageSize) {
        return categoryDAO.findWithPage(page, pageSize);
    }

    public int getTotalPages(int pageSize) {
        long totalCount = categoryDAO.count();
        return (int) Math.ceil((double) totalCount / pageSize);
    }

    public long getTotalCount() {
        return categoryDAO.count();
    }

    public boolean saveCategory(Category_24110280 category) {
        if (category.getCategoryId() == null || category.getCategoryId() == 0) {
            return categoryDAO.insert(category);
        } else {
            return categoryDAO.update(category);
        }
    }

    public boolean deleteCategory(Integer categoryId) {
        return categoryDAO.delete(categoryId);
    }
}
