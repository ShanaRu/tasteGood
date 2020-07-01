package com.domain;

public class Steps {
    private Integer menuId;
    private String step;
    private String stepChar;

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    public String getStep() {
        return step;
    }

    public void setStep(String step) {
        this.step = step;
    }

    public String getStepChar() {
        return stepChar;
    }

    public void setStepChar(String stepChar) {
        this.stepChar = stepChar;
    }

    @Override
    public String toString() {
        return "Steps{" +
                "menuId=" + menuId +
                ", step='" + step + '\'' +
                ", stepChar='" + stepChar + '\'' +
                '}';
    }
}
