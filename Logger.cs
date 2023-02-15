using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Windows.Forms;
using System.Configuration;

namespace Exam_ADO
{
    /// <summary>
    /// класс, осуществляющий вход в систему
    /// </summary>
    internal class Logger
    {
        /// <summary>
        /// Вход в систему
        /// </summary>
        /// <param name="username"></param>
        /// <param name="pass"></param>
        /// <returns>Новый объект User</returns>
        internal User Login(string username, string pass)
        {
            string connectionString = "Server=BATYA\\SQLEXPRESS; Database=Books; Trusted_Connection=True;";
            // Создание подключения
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand($@"SELECT * from UsersSet WHERE username = '{username}' and password = '{pass}'", connection);
                connection.Open();
                SqlDataReader sqldatareader = command.ExecuteReader();
                if (sqldatareader.HasRows)
                {
                    User user = new User();
                    while (sqldatareader.Read())
                    {
                        user.Id = sqldatareader.GetInt32(0);
                        user.name = sqldatareader.GetString(3);
                    }
                    sqldatareader.Close();
                    return user;
                }
                else
                    return null;
            }
        }
    }
}