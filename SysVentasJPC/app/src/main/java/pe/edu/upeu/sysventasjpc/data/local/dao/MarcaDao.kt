package pe.edu.upeu.sysventasjpc.data.local.dao

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update
import kotlinx.coroutines.flow.Flow
import pe.edu.upeu.sysventasjpc.modelo.Marca

@Dao
interface MarcaDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertarEntidad(to: Marca)
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertarEntidadRegs(to: List<Marca>)
    @Update
    suspend fun modificarEntidad(to: Marca)
    @Delete
    suspend fun eliminarEntidad(to: Marca)

    @Query("select * from marca")
    fun reportatEntidad(): Flow<List<Marca>>

    @Query("select * from marca where id_marca=:idx")
    fun buscarEntidad(idx: Long): Flow<Marca?>
}