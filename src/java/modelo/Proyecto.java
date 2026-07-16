package modelo;

public class Proyecto {
    private int id;
    private String semana;
    private String titulo;
    private String descripcion;
    private String tecnologia1;
    private String tecnologia2;
    private String imagen;
    
    public Proyecto() {}
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getSemana() { return semana; }
    public void setSemana(String semana) { this.semana = semana; }
    
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    
    public String getTecnologia1() { return tecnologia1; }
    public void setTecnologia1(String tecnologia1) { this.tecnologia1 = tecnologia1; }
    
    public String getTecnologia2() { return tecnologia2; }
    public void setTecnologia2(String tecnologia2) { this.tecnologia2 = tecnologia2; }
    
    public String getImagen() { return imagen; }
    public void setImagen(String imagen) { this.imagen = imagen; }
}