package com.domain;

public class Ingredients {
    private Integer menuId;
    private String ingredient;
    private String dosage;

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    public String getIngredient() {
        return ingredient;
    }

    public void setIngredient(String ingredient) {
        this.ingredient = ingredient;
    }

    public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }

    @Override
    public String toString() {
        return "Ingredients{" +
                "menuId=" + menuId +
                ", ingredient='" + ingredient + '\'' +
                ", dosage='" + dosage + '\'' +
                '}';
    }
}
