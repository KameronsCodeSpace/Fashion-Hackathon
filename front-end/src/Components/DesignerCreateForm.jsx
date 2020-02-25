import React, {useState} from "react";
import '../App.css';

const DesignerCreateForm = () => {
    const [imgUrl, setImgUrl] = useState('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRa9NQl0OadsMFUDS-0ycSNaU7OJiBvgefKvC8m7SLkAph1V7ya')
    const imageStyle = {
        'border-style': 'solid',
        'margin-right': '70%',
        'display': 'block',
        'margin-left': 'auto',
        'margin-right': 'auto',
    }
   

  return (
    <div>
      <br />
      <img  style ={imageStyle} src={imgUrl} alt="default image"/>
      <form>
        <input type="file" onInput={(e)=>{
          setImgUrl(e.target.value)
        }}/>
      </form>
    </div>
  );
};

export default DesignerCreateForm;
