package com.domain;

public class Step {
    private int menuId;
    private String step;
    private String stepChar;

    public int getMenuId() {
        return menuId;
    }

    public void setMenuId(int menuId) {
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
        return "step{" +
                "menuId=" + menuId +
                ", step='" + step + '\'' +
                ", stepChar='" + stepChar + '\'' +
                '}';
    }
}
