// Crear un array de objetos
const mockData = [
    { id: 1, name: "John", age: 25 },
    { id: 2, name: "Jane", age: 30 },
    { id: 3, name: "Alex", age: 22 },
    { id: 4, name: "Emily", age: 27 },
    { id: 5, name: "Mike", age: 33 },
  ];
  
  // Crear funcion para obtener información.
  const getAllData = () => {
    return mockData;
  };
  
  // Crear funcion para obtener información por ID.
  const getDataById = (id) => {
    return mockData.find((data) => data.id === id);
  };
  
  // Exportar las funciones para poder usarlas en otros modulos
  module.exports = {
    getAllData,
    getDataById,
  };