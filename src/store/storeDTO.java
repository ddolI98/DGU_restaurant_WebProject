package store;

public class storeDTO {
    Integer restID;
    Integer ownerID;
    String name;
    String explane;
    String photoCode;
    String phoneNumber;
    String startHours;
    String endHours;
    Float score;


    public Integer getRestID() {
        return restID;
    }

    public void setRestID(Integer restID) {
        this.restID = restID;
    }

    public Integer getOwnerID() {
        return ownerID;
    }

    public void setOwnerID(Integer ownerID) {
        this.ownerID = ownerID;
    }

    public String getRestName() { return name; }

    public void setRestName() { this.name = name; }

    public String getExplane() { return explane; }

    public void setExplane() { this.explane = explane; }

    public String getPhotoCode() { return photoCode; }

    public void setPhotoCode() { this.photoCode = photoCode; }

    public String getPhoneNumber() { return phoneNumber; }

    public void setPhoneNumber() { this.phoneNumber = phoneNumber; }

    public String getStartHours() { return startHours; }

    public void setStartHours() { this.startHours = startHours; }

    public String getEndHours() { return endHours; }

    public void setEndHours() { this.endHours = endHours; }

    public Float getScore() { return score; }

    public void setScore() { this.score = score; }
}
