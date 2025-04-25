package pe.edu.upeu.sysventasjpc.repository

import android.util.Log
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.launch
import pe.edu.upeu.sysventasjpc.data.local.dao.MarcaDao
import pe.edu.upeu.sysventasjpc.data.remote.RestMarca
import pe.edu.upeu.sysventasjpc.modelo.Marca
import pe.edu.upeu.sysventasjpc.utils.TokenUtils
import pe.edu.upeu.sysventasjpc.utils.isNetworkAvailable
import javax.inject.Inject

interface MarcaRepository {
    suspend fun findAll(): List<Marca>
    suspend fun findAllR(): Flow<List<Marca>>
    suspend fun saveMarca(marca: Marca)
    suspend fun updateMarca(marca: Marca)
    suspend fun deleteMarca(marca: Marca): Boolean
    suspend fun getMarcaById(id: Long): Flow<Marca?>
}


class MarcaRepositoryImp @Inject constructor(
    private val rest: RestMarca,
    private val dao: MarcaDao,
): MarcaRepository{

    override suspend fun findAll(): List<Marca> {
        val response = rest.reportarMarcas(TokenUtils.TOKEN_CONTENT)
        return if (response.isSuccessful) response.body() ?: emptyList()
        else emptyList()
    }

    override suspend fun findAllR(): Flow<List<Marca>> {
        try {
            CoroutineScope(Dispatchers.IO).launch{
                if(isNetworkAvailable(TokenUtils.CONTEXTO_APPX)){
                    val data=rest.reportarMarcas(TokenUtils.TOKEN_CONTENT).body()!!
                    dao.insertarEntidadRegs(data)
                }
            }
        }catch (e:Exception){
            Log.e("ERROR", "Error: ${e.message}")
        }
        return dao.reportatEntidad()
    }


    override suspend fun saveMarca(marca: Marca) {
        try {
            if (isNetworkAvailable(TokenUtils.CONTEXTO_APPX)) {
                rest.insertarMarca(TokenUtils.TOKEN_CONTENT, marca)
            } else {
                dao.insertarEntidad(marca)
            }
        } catch (e: Exception) {
            Log.e("ERROR", "Error al guardar marca: ${e.message}")
        }
    }
    override suspend fun updateMarca(marca: Marca) {
        try {
            if (isNetworkAvailable(TokenUtils.CONTEXTO_APPX)) {
                val response = rest.actualizarMarca(TokenUtils.TOKEN_CONTENT, marca.idMarca,
                    marca)
                if (response.isSuccessful) {
                    dao.modificarEntidad(marca)
                }
            } else {
                dao.modificarEntidad(marca)
            }
        } catch (e: Exception) {
            Log.e("ERROR", "Error al actualizar marca: ${e.message}")
        }
    }
    override suspend fun deleteMarca(marca: Marca): Boolean {
        try {
            if (isNetworkAvailable(TokenUtils.CONTEXTO_APPX)) {
                val response = rest.deleteMarca(TokenUtils.TOKEN_CONTENT, marca.idMarca)
                if (response.isSuccessful) {
                    dao.eliminarEntidad(marca)
                }
            } else {
                dao.eliminarEntidad(marca)

            }
            return true
        } catch (e: Exception) {
            Log.e("ERROR", "Error al eliminar marca: ${e.message}")
            return false
        }
    }
    override suspend fun getMarcaById(id: Long): Flow<Marca?> {
        return if (isNetworkAvailable(TokenUtils.CONTEXTO_APPX)) {
            try {
                val response = rest.getMarcasId(TokenUtils.TOKEN_CONTENT, id)
                if (response.isSuccessful) {
                    response.body()?.let { dao.insertarEntidad(it) } // sincroniza con Room
                }
            } catch (e: Exception) {
                Log.e("ERROR", "Error al obtener marca desde API: ${e.message}")
            }
            dao.buscarEntidad(id)
        } else {
            dao.buscarEntidad(id)
        }
    }
}