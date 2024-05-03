import java.util.ArrayList;

public class BaseDeDonnéesSQL extends SQLiteOpenHelper{
    private static final String DATABASE_NAME = "Ma base de données";
    private static final int DATABASE_VERSION = 1;
    public BaseDeDonnéesSQL(Context context){
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }
    @Override
    public void onCreate(SQLiteDatabase db){
        String strSql = "CREATE TABLE ma_table (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, surname TEXT, age INTEGER)"
        db.execSQL(strSql);
    }
    @Override
    public void onCreate(SQLiteOpenHelper db, int oldVersion, int newVersion){
        /*Code qui s'exécute quand on installe une nouvelle version*/
    }
    
    /* Getters et Setters */
    

    public ArrayList<MaClasse> getAllDatas(){
        ArrayList<MaClasse> donnees = new ArrayList<>();
        String strSql = "SELECT * FROM ma_table";
        Cursor cursor = this.getWritableDataBase().rawQuery(strSql, null);
        if(cursor.moveToFirst()){
            while(!cursor.isAfterLast){
                int id = 
            }
        }
    }
}