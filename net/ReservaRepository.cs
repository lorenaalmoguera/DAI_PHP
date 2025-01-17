namespace aspnet.Services;

using aspnet.Models;
using aspnet.Services;
using Dapper;
using FirebirdSql.Data.FirebirdClient;

public interface IReservaRepository {
    Task<int> getIDCompania();
    Task insertarCompania(Compania compania);
    Task<IEnumerable<Ciudad>> listarCiudades(); // Ensure this is included
}


public class ReservaRepository: IReservaRepository{
    public readonly string? connstr;

    public ReservaRepository(IConfiguration configuration){
        connstr = configuration.GetConnectionString("DefaultConnection");
    }

    public async Task<int> getIDCompania(){
        using (FbConnection con = new FbConnection(connstr)){
            con.Open();
            string sql = "SELECT MAX(IDCOMPANIA) as id FROM COMPANIA";
            using(FbCommand command = new FbCommand(sql, con)){
                return Convert.ToInt32(await command.ExecuteScalarAsync()) + 1;
            }
        }
    }

    public async Task insertarCompania(Compania compania){
        using var connection = new FbConnection(connstr);
        await connection.QueryAsync(@"INSERT INTO COMPANIA(IDCOMPANIA, COMPANIA) VALUES (@IDCOMPANIA, @NOMBRECOMPANIA);", compania);
    }

    public async Task<IEnumerable<Ciudad>> listarCiudades(){
        using var connection = new FbConnection(connstr);
        var sql ="SELECT * FROM CIUDAD";
        return await connection.QueryAsync<Ciudad>(sql);
    }

}