using System.Collections.Generic;

namespace NerdDinner.DinnerApi.Repositories
{
    public interface IRepository<T>
    {
        IEnumerable<T> GetAll();
    }
}
