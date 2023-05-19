import { useQuery } from "react-query";

function App() {
  const { data } = useQuery("news", async () => {
    const url = import.meta.env.VITE_API_URL;
    const response = await fetch(`${url}/news`);
    return response.json();
  });

  if (!data) {
    return <div>Loading...</div>;
  }

  return (
    <ol>
      {data.map((item) => (
        <li key={item.id}>
          <h3>{item.title}</h3>
          <p>{item.content}</p>
        </li>
      ))}
    </ol>
  );
}

export default App;
